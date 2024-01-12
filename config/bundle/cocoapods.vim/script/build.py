import os
import re
import subprocess
import sys


# The order of these matters #superhack
attrs = [
    'source_files',
    'license',
    'git'
    'source',
    'requires_arc',
    'homepage',
    'weak framework',
    'framework',
    'libraries',
    'tag',
    'commit',
    'version',
    'the description',
    'summary',
    'name',
    'social media url',
    'warnings must not be disabled',
]
mappings = {
    'commit': 'source',
    'git': 'source',
    'social media url': 'social_media_url',
    'tag': 'source',
    'the description': 'description',
    'warnings must not be disabled': 'compiler_flags',
    'weak framework': 'weak_frameworks',
}
file_contents = {}


def get_lines(filename):
    if filename in file_contents:
        return file_contents[filename]
    with open(filename, "r") as f:
        lines = f.readlines()
        file_contents[filename] = lines
        return lines


def command_success(command):
    with open(os.devnull, "w") as f:
        return subprocess.call(command.split(),
                               stderr=f,
                               stdout=f) == 0


def spec_identifier(filename):
    contents = get_lines(filename)
    for line in contents:
        if "Pod::Spec.new" in line:
            create_line = line
            break
    return re.findall(r"\|\w+\|", create_line)[0].strip("|")


def run_command(command):
    out = subprocess.Popen(command.split(),
                           stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)
    return out.stdout.readlines()


def line_of_attr(attr, fname):
    identifier = spec_identifier(fname)
    contents = get_lines(fname)
    for idx, line in enumerate(contents):
        string = "%s.%s" % (identifier, attr)
        if line.lstrip(" #").startswith(string):
            return idx + 1
    return idx


def get_errors(output, filename):
    errs = []
    for err in output:
        for w in attrs:
            added = False
            if w in err:
                attr = mappings.get(w, w)
                ln = line_of_attr(attr, filename)
                errs.append((ln, err))
                added = True
                break

        if not added:
            errs.insert(0, (1, err))
    return sorted(errs, key=lambda tup: tup[0])


def clean_output(output):
    output = output[2:]
    output = output[:-3]
    cleaned = []
    for line in output:
        l = line.strip(' -\n\t')
        if l:
            cleaned.append(l.lower())
    return cleaned


def main(filename):
    if not command_success("pod --version"):
        print "Pod command missing or broken"
        return

    output = run_command("pod spec lint " + filename)
    cleaned = clean_output(output)
    errs = get_errors(cleaned, filename)
    for ln, err in errs:
        print "%s:%d:%s" % (filename, ln, err)


if __name__ == '__main__':
    main(sys.argv[1])

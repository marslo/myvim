if did_filetype() 
  finish 
endif 
if getline(1) =~ '^#!.*[/\\]groovy\>' 
  setf groovy 
endif 

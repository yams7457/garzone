function init()
  
  current_note = 12
  first_note_of_triad = 12
  current_triad_table = {}
  current_sequence = {}
  previous_inversion = nil
  previous_quality = nil


end

--tab.triads organized by [quality][which note we're starting on][inversion]

triads = {"maj", "min", "aug", "dim"}

  triads["maj"] = {"root", "third", "fifth"}
  
    triads["maj"]["root"] = {"no", "first", "second"}
    
        triads["maj"]["root"]["no"] = {4,7}
        triads["maj"]["root"]["first"] = {-5, -8}
        triads["maj"]["root"]["second"] = {4, -5}
        
    triads["maj"]["third"] = {"no", "first", "second"}
    
        triads["maj"]["third"]["no"] = {-4, 3}
        triads["maj"]["third"]["first"] = {3, 8}
        triads["maj"]["third"]["second"] = {-4, -5}
    
    triads["maj"]["fifth"] = {"no", "first", "second"}

        triads["maj"]["fifth"]["no"] = {-7, -3}
        triads["maj"]["fifth"]["first"] = {-3, 5}
        triads["maj"]["fifth"]["second"] = {5, 9}   
        
    
  triads["min"] = {"root", "third", "fifth"}
  
    triads["min"]["root"] = {"no", "first", "second"}

        triads["min"]["root"]["no"] = {3, 7}
        triads["min"]["root"]["first"] = {-9, -5}
        triads["min"]["root"]["second"] = {-5, 3}
  
    triads["min"]["third"] = {"no", "first", "second"}
    
        triads["min"]["third"]["no"] = {-3, 4}
        triads["min"]["third"]["first"] = {4, 9}
        triads["min"]["third"]["second"] = {-8, -3}
  
    triads["min"]["fifth"] = {"no", "first", "second"}
    
        triads["min"]["fifth"]["no"] = {-4, -7}
        triads["min"]["fifth"]["first"] = {-4, 5}
        triads["min"]["fifth"]["second"] = {5, 8}
        
        
  triads["aug"] = {"no", "first", "second"}
  
    triads["aug"]["no"] = {4, 8}
    triads["aug"]["first"] = {-8, -4}
    triads["aug"]["second"] = {-8, 4}
        
    
  triads["dim"] = {"no", "first", "second"}
  
    triads["dim"]["no"] = {3, 6}
    triads["dim"]["first"] = {-6, -3}
    triads["dim"]["second"] = {-6, 3}
    
function set_up_a_sequence()
  for i = 1,12 do
    current_sequence[i] = nil
  end
  set_up_the_triad()
  set_up_the_triad()
  set_up_the_triad()
  set_up_the_triad()
  tab.print(current_sequence)
end
 
function set_up_the_triad()
  move_a_halfstep()
  determine_the_quality()
  which_part_of_the_triad_are_we_at()
  which_inversion()
  generate_notes()
end

function move_a_halfstep()
  
  local flip = math.random(0, 1)
  
  if flip == 1 then
    first_note_of_triad = current_note + 1
  elseif flip == 0 then 
    first_note_of_triad = current_note - 1
  end
  
  current_note = first_note_of_triad
  
  if current_note <= -12 then current_note = current_note + 12
  elseif current_note >= 36 then current_note =current_note - 12
  end
  
  table.insert(current_sequence, current_note)
end

function determine_the_quality()
  quality = math.random(1,4)
end

function which_part_of_the_triad_are_we_at()
  
  if quality <= 2 then
    part = triads[triads[quality]][math.random(1,3)]
  end
  
end

function which_inversion()
  
  inversion = triads["aug"][math.random(1,3)]

  if previous_quality == quality then
    
    if previous_inversion == inversion then
      
      which_inversion()
    
    end
    
  end

end

function generate_notes()
  
  previous_inversion = inversion
  previous_quality = quality
  
  if quality <= 2 then
  
  current_triad_table = {triads[triads[quality]][part][inversion][1], triads[triads[quality]][part][inversion][2]}

  end
  
  if quality >= 3 then
    
  current_triad_table = {triads[triads[quality]][inversion][1], triads[triads[quality]][inversion][2]}
  
  end
  
  
  first_note_to_play = math.random(1,2)
  
  current_note = first_note_of_triad + current_triad_table[first_note_to_play]
  
  if current_note <= -12 then current_note = current_note + 12
  elseif current_note >= 36 then current_note =current_note - 12
  end
  
  table.insert(current_sequence, current_note)
  
  if first_note_to_play == 1 then
    current_note = first_note_of_triad + current_triad_table[2]
  elseif first_note_to_play == 2 then
    current_note = first_note_of_triad + current_triad_table[1]
  end
  
  if current_note <= -12 then current_note = current_note + 12
  elseif current_note >= 36 then current_note =current_note - 12
  end
  
  table.insert(current_sequence, current_note)
    
  
end

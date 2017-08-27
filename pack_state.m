function [id ce]= pack_state(initial_dormants, cat_ends) %une cuatro intervalos pequenhos en uno

   global hires_qty lowres_mul
    initial_dormants = initial_dormants' ;
    
   id = [initial_dormants(1:hires_qty, :);
          sum(initial_dormants(hires_qty+1:hires_qty+lowres_mul, :)) ;
          initial_dormants(hires_qty+lowres_mul+1:end-1, :)] ; %nuevas condiciones iniciales, la semana sig. q se va a simular
     
  
   ce = [cat_ends(1:hires_qty);
         cat_ends(hires_qty+lowres_mul);
         cat_ends(hires_qty+lowres_mul+1:end-1)] ; %ce son los nuevos cat_ends
    
end

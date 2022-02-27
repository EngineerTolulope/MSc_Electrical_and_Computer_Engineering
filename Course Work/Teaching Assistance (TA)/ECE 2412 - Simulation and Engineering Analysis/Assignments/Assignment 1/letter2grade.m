% The function must be saved as letter2grade.m
function grade=letter2grade(score)
 
    if (score>=90 && score <=100)
        grade= 'A';
    elseif (score>=80 && score <90)
        grade= 'B';
   elseif (score>=70 && score <80)
        grade= 'C';
   elseif (score>=60 && score <70)
        grade= 'D';
   elseif (score>=0 && score <60)
        grade= 'F';
    else
        error('Error. Input must be a numeric value between 0 to 100')
    end
end
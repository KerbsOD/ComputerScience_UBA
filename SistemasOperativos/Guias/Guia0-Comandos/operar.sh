echo "Ingrese dos numeros:"
echo -n "A: "
read a
echo -n "B: "
read b 
sum=$(($a+$b))
prod=$(($a*$b))
echo "Sum" $sum
echo "Prod" $prod

mayor=$(($sum>$prod))
igual=$(($sum==$prod))
menor=$(($sum<$prod))

if [ $igual == 1 ]; then 
  echo "Sum equal to prod"
elif [ $menor == 1 ]; then 
  echo "Sum smaller than prod"
else 
  echo "Sum bigger than prod" 
fi

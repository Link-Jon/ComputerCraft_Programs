function bonemeal()
  turtle.select(16)
  a=turtle.getItemCount(16)
  turtle.place()
  if turtle.getItemCount(16) < a then
    bonemeal()
  end
end
bonemeal()


#line = "BudgetArms C-13              P       -1     P     E       1d6 (5mm)               8         2           ST     50m      75       CP20\n"
#line = "Militech Crusher SSG      SHT        -1/-3   J   C        3d6 (20ga) (B9)         6         2           ST     12/25m   450      Chr1"
#line = "H&K P-11                     P       +0     J     P       4d6+1 (6mmRkt)          5         1           VR     50m      700      ES"
#line = 'IMI "Gamdaii" GL       HVY           +0     N     E       (25mm/10ga)             1         1           ST     100m     950      SOF2'

require 'csv'

weapons = File.open("db/weapons.txt") do |file|
  current_category = ""
  file.collect do |line|
    case line.split.length
      when 0 then next
      when 1..3 then (current_category = line.titleize.chomp) and next
    end

    if ammo = line[/\(.*\)/]
      line.gsub!(/\(.*\)/, "")
    end
    cols = line.split
    source = cols.pop
    cost = cols.pop
    range = cols.pop
    reliability = cols.pop
    rof = cols.pop
    shots = cols.pop
    damage = cols.pop
    if damage.length == 1
      availability = damage
      damage = nil
    else
      availability = cols.pop
    end
    concealability = cols.pop
    accuracy = cols.pop
    type = cols.pop
    name = cols.join(" ")

    [current_category, name, type, accuracy, concealability, availability, damage, ammo, shots, rof, reliability, range, cost, source]
  end
end.compact

CSV.open("db/weapons.csv", "w") do |csv|
  csv << %w[category name type accuracy concealability availability damage ammo shots rof reliability range cost source]
  weapons.each do |weapon|
    csv << weapon
  end
end

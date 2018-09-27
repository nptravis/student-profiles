Dir[File.join(Rails.root, 'db', 'seeds', 'standard_seeds.rb')].sort.each do |seed|
  load seed
end


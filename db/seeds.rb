Dir[File.join(Rails.root, 'db', 'seeds', 'section_seeds.rb')].sort.each do |seed|
  load seed
end


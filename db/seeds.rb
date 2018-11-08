Dir[File.join(Rails.root, 'db', 'seeds', 'transcript_seeds.rb')].sort.each do |seed|
  load seed
end


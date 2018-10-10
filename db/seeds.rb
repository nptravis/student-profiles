Dir[File.join(Rails.root, 'db', 'seeds', 'quarter_comment_seeds.rb')].sort.each do |seed|
  load seed
end


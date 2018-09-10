class CollectionService

	def all_homs(collection)
		collection.select {|x| x.standard.hom?} 
	end

	def all_standards(collection)
		collection.select {|x| !x.standard.hom?} 
	end

end
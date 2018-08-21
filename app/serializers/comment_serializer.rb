class CommentSerializer

	def self.serialize(comment)

	serialized_comment = '{'
 
    serialized_comment += '"id": ' + comment.id.to_s + ', '
    serialized_comment += '"author": "' + comment.user + '", '
    serialized_comment += '"content": "' + comment.content + '", '
    serialized_comment += '"student": "' + comment.student + '"'
 
    # and end with the close brace
    serialized_comment += '}'

	end

end 
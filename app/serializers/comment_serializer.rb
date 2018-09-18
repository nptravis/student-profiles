class CommentSerializer < ApplicationSerializer
	attributes :content, :id
	belongs_to :user, serializer: UserSerializer
	belongs_to :student, serializer: StudentSerializer




	# def self.serialize(comment)

	# serialized_comment = '{'
 #    serialized_comment += '"id": ' + comment.id.to_s + ', '
 #    serialized_comment += '"author": "' + comment.user + '", '
 #    serialized_comment += '"content": "' + comment.content + '", '
 #    serialized_comment += '"student": "' + comment.student + '"'
 #    serialized_comment += '}'

	# end

end 
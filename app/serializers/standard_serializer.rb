class StandardSerializer < ApplicationSerializer
  attributes :id, :standard_name, :identifier
  has_many :grades, serializer: GradeStandardSerializer

end

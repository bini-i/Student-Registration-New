module Filters
    module StudentFilterScopes
        extend FilterScopeable

        # we define scopes with our new method
        filter_scope :admission_year, ->(admission_year) { where(admission_year:) }
        filter_scope :class_year, ->(class_year) { where(class_year:) }
        filter_scope :section, ->(section) { where(section:) }
    end

    class StudentFilterProxy < FilterProxy
        def self.query_scope = Student
        def self.filter_scopes_module = Filters::StudentFilterScopes
    end
end
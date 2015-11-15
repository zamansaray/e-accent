class Search
  attr_reader :skill_ids

  def initialize options = {}
    @skill_ids = options
      .fetch(:skill_ids, "")
      .select{|id| !id.empty?}
  end

  def workers
    return [] if @skill_ids.empty?

    skills_sql = @skill_ids.map do |skill_id|
      "SELECT x.user_id FROM skills_users as x WHERE x.skill_id = #{skill_id}"
    end.join ' INTERSECT '
    sql = "SELECT * FROM users INNER JOIN (#{skills_sql}) as skills ON users.id = skills.user_id"
    User.find_by_sql sql
  end

end

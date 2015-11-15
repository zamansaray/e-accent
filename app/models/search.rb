class Search
  attr_reader :skill_ids

  def initialize options = {}
    @skill_ids = options
      .fetch(:skill_ids, "")
      .select{|x| x != ''}
  end

  def workers
    sql = @skill_ids.map do |skill_id|
      "SELECT x.user_id as id FROM skills_users as x WHERE x.skill_id = #{skill_id}"
    end.join ' INTERSECT '
    workers = ActiveRecord::Base.connection.execute(sql).map {|x| x['id']}
    User.where id: workers
  end

end

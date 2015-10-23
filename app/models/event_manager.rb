class EventManager
  def self.database
    if ENV["RACK_ENV"] == "test"
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager.sqlite3")
    end
  end

  def self.create(task)
    database.from(:tasks).insert(title: task[:title], description: task[:description])
  end

  def self.update(id, data)
    database.from(:tasks).where(:id => id).update(title: data[:title], description: data[:description])
  end

  def self.delete(id)
    database.from(:tasks).where(:id => id).delete
  end

  def self.raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def self.all
    tasks = database.from(:tasks).to_a
    tasks.map { |data| Task.new(data) }
  end

  def self.raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def self.find(id)
    task = database.from(:tasks).where(:id => id).to_a.first
    Task.new(task)
  end

  def self.delete_all
    database.from(:tasks).delete
  end
end

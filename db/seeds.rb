# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.create(title: "Smith family chores", description: "Space to keep track of recurring household tasks, like laundry & doctor's appointments")

User.create(first_name: 'Jane', last_name: 'Smith', email: 'js@test.com', password: 'testtest', password_confirmation: 'testtest')
UserGroupAssignment.create(user:User.last, group:Group.first, admin: true)

User.create(first_name: 'Abigail', last_name: 'Smith', email: 'as@test.com', password: 'testtest', password_confirmation: 'testtest')
UserGroupAssignment.create(user:User.last, group:Group.first)

Group.first.tasks << Task.new(title: "Launder towels",
                              due_date: Date.today - 2.months,
                              created_at: Date.today - 2.months,
                              updated_at: Date.today - 2.months,
                              recurrence_type: "Weekly",
                              separation: 2,
                              user_id: 1,
                            )
Group.first.tasks << Task.new(title: "Launder sheets",
                              due_date: Date.today - 2.months,
                              created_at: Date.today - 2.months,
                              updated_at: Date.today - 2.months,
                              recurrence_type: "Weekly",
                              separation: 2,
                              user_id: 2,
                            )
Group.first.tasks << Task.new(title: "Take out the trash",
                              description: 'Empty kitchen & bathroom trashcans, then place the trash & recycling bins on the street',
                              due_date: Date.today - 2.weeks,
                              recurrence_type: "Weekly",
                              separation: 1,
                            )
Group.first.tasks << Task.new(title: "Pick up medication from pharmacy",
                                  description: 'Walgreens at 1123 Example Road',
                                  due_date: Date.today + 1,
                                  recurrence_type: "Monthly",
                                  separation: 1,
                                  visibility_delay: 15,
                            )
Group.first.tasks << Task.new(title: "Call handyman for kitchen sink",
                                  description: '1(800)111-0000, Bob Example',
                                  due_date: Date.today + 1,
                            )
Group.first.tasks << Task.new(title: "Book dentist appointment",
                                  due_date: Date.today + 1.weeks,
                                  recurrence_type: "Monthly",
                                  separation: 6,
                                  visibility_delay: 30,
                            )
Group.first.tasks << Task.new(title: "Plan graduation celebration",
                                  due_date: Date.today + 1.months,
                                  visibility_delay: 45,
                            )

Group.create(title: "Petfinder dashboard project", description: "Open-source community effort to optimize pet adoptions in Example county")
UserGroupAssignment.create(user:User.first, group:Group.last)

User.create(first_name: 'Taylor', last_name: 'Sanchez', email: 'ts@test.com', password: 'testtest', password_confirmation: 'testtest')
UserGroupAssignment.create(user:User.last, group:Group.last, admin: true)

Group.last.tasks << Task.new(title: "Get API credentials",
                              description: 'Read-only access - special permission may be required from maintenance team to prevent up the rate limit',
                              due_date: Date.today + 9,
                            )
Group.last.tasks << Task.new(title: "Draft project update",
                              description: 'What was accomplished this week? Next steps? Any blockers?',
                              due_date: Date.today + 3,
                              recurrence_type: "Weekly",
                              separation: 2,
                            )

# fill history with randomly on-time task instances
Task.select(&:is_recurring?).each do |task|
  while true do
    instance = task.current_instance
    if instance.due_date > Date.today then break end

    instance.complete = true
    instance.user ||= instance.group.users.sample
    instance.updated_at = instance.due_date + Random.rand(-5..5)
    instance.save!
    task.next_task_instance
  end
end
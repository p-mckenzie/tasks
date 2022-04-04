# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.create(title: "Test organization", description: "Holds seed tasks and users")

User.create(first_name: 'Paige', last_name: 'McKenzie', email: 'mp@test.com', password: 'testtest', password_confirmation: 'testtest')
UserGroupAssignment.create(user:User.first, group:Group.first, admin: true)

User.create(first_name: 'John', last_name: 'Doe', email: 'jd@test.com', password: 'testtest', password_confirmation: 'testtest')
UserGroupAssignment.create(user:User.last, group:Group.first)

Group.first.tasks << Task.new(title: "Weekly recurring item", description: '', due_date: Date.today + 1, recurrence_type: "Weekly", separation: 1)
Group.first.tasks << Task.new(title: "Daily recurring item", description: '', due_date: Date.today + 1, recurrence_type: "Daily", separation: 1)
Group.first.tasks << Task.new(title: "Single instance item", description: '', due_date: Date.today + 1)

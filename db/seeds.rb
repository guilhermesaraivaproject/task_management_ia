# Create a test user
user = User.create!(
  email: 'test@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

puts "Created user: #{user.email}"

# Create some sample tasks
tasks = [
  {
    title: 'Complete project proposal',
    description: 'Write and submit the project proposal for Q2',
    status: 'pending',
    due_date: Date.tomorrow
  },
  {
    title: 'Review team performance',
    description: 'Conduct monthly review of team members',
    status: 'in_progress',
    due_date: Date.current + 1.week
  },
  {
    title: 'Update documentation',
    description: 'Update API documentation with new endpoints',
    status: 'completed',
    due_date: Date.yesterday
  },
  {
    title: 'Client presentation',
    description: 'Present project status to client stakeholders',
    status: 'pending',
    due_date: Date.current + 3.days
  }
]

tasks.each do |task_attrs|
  task = user.tasks.create!(task_attrs)
  puts "Created task: #{task.title}"
end

puts "Seed data created successfully!"

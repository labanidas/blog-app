# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: "doctor@ld.in", password: "user123",is_doctor:true)
User.create(email: "receptionist@ld.com", password: "user123")



30.times do |i|
    p = Patient.create(
      name: "patient#{i + 1}",
      number: '8888999912',
      birthdate: Date.parse('2001-01-06')
    )
    p.created_at = rand(10).months.ago
    p.save
  end
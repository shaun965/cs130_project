# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doctor.create(email: "a@a.a", password: "11111111")

20.times do |x|
	patient = Doctor.first.patients.create(name: Faker::Name.name, birthdate: Faker::Date.birthday(18, 65), height: rand(150...200), weight: rand(50...150), sex: "male", email: Faker::Internet.email, password: "11111111")
	20.times do |x|
		patient.blood_pressures.create(high: rand(120...180), low: rand(60...110))
		patient.blood_sugars.create(number: rand(3...8))
		patient.blood_fat.create(number: rand(100...250))
	end
end


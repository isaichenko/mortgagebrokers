# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Creating required  Roles for MortgageBrokers Application
roles = Role.create([{ name: 'Admin' }, { name: 'Borrower' }, { name: 'Broker' }, { name: 'Lender' }])
packages = Package.create([
	{ name: 'Free',cost: 0 , coins: 0 , benefit_description: 'No benefits' },
	{ name: 'Package1',cost: 25 , coins: 500 , benefit_description: 'Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum ' }, 
	{ name: 'Package2',cost: 50 , coins: 1000, benefit_description: 'Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum '}, 
	{ name: 'Package3',cost: 75, coins: 2500, benefit_description: 'Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum ' }, 
	{ name: 'Package4',cost: 100, coins: 4000, benefit_description: 'Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum '}
])

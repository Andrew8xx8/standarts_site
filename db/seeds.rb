# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.create(name: "super", description: "Супер администратор")
Role.create(name: "admin", description: "Администратор")
profile = Profile.create(surname: "Иванов", name: "Иван", patronymic: "Иванович", mail:"mail@mail.ru")
company = Company.create(name:"TheCompany", opf: "ООО")
UserCreateType.create(login: "admin", password: "123", profile_id: profile.id, role_id: role.id, company_id: company.id)

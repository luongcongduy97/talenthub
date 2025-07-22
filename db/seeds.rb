# Tạo user admin nếu chưa có
admin_email = "admin@talenthub.com"
admin_password = "password123"

admin = User.find_or_create_by!(email: admin_email) do |user|
  user.password = admin_password
  user.password_confirmation = admin_password
end

# Gán role admin
admin.add_role(:admin) unless admin.has_role?(:admin)

puts "Admin user created: #{admin_email} with password: #{admin_password}"

# Tạo một vài công ty mẫu
techcorp = Company.find_or_create_by!(name: "TechCorp", industry: "Software")
healthco = Company.find_or_create_by!(name: "HealthCo", industry: "Healthcare")

# Tạo người dùng cho nhân viên
alice_user = User.find_or_create_by!(email: "alice@talenthub.com") do |user|
  user.password = admin_password
  user.password_confirmation = admin_password
end

bob_user = User.find_or_create_by!(email: "bob@talenthub.com") do |user|
  user.password = admin_password
  user.password_confirmation = admin_password
end

# Tạo nhân viên mẫu
Employee.find_or_create_by!(name: "Alice", user: alice_user, company: techcorp) do |employee|
  employee.position = "Developer"
end

Employee.find_or_create_by!(name: "Bob", user: bob_user, company: healthco) do |employee|
  employee.position = "Analyst"
end

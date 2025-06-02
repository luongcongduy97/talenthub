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

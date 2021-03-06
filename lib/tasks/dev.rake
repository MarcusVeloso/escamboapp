namespace :dev do

  desc "Setup Development"
  task setup: :environment do

  images_path = Rails.root.join('public','system')

  puts "Executando o setup para desenvolvimento..."
    
    puts "APAGANDO DB... #{%x(rake db:drop)}" 
    puts "APAGANDO IMAGENS DE public/system #{%x(rm -rf #{images_path})}"
    puts "CRIANDO DB... #{%x(rake db:create)}" 
    puts %x(rake db:migrate) 
    puts %x(rake db:seed)
    puts %x(rake dev:generate_admins)
    puts %x(rake dev:generate_members)
    puts %x(rake dev:generate_ads)

  puts "Setup executado   com sucesso!"
  end

  #########################################################################

  desc "Cria administradores Fake"
  task generate_admins: :environment do

	puts "Cadastrando Administradores Fake..."
		10.times do
			Admin.create!(name: Faker::Name.name,
										email: Faker::Internet.email,
										password: "123456",
										password_confirmation: "123456",
										role:[0,1].sample)
		end

	puts "Administradores Fake cadastrados com sucesso!"
  end

  #########################################################################

  desc "Cria Membros Fake"
  task generate_members: :environment do
    puts "Cadastrando Membros..."

    50.times do
      Member.create!(
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456"
        )
    end
    puts "Membros cadastrados com sucesso!"
  end    

  #########################################################################

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
  	puts "Cadastrando ANÚNCIOS.."
    
  	50.times do
  		Ad.create!(
  				title: Faker::Lorem.sentence([2,3,4,5].sample),
  				description: mardown_fake,
  				member: Member.all.sample,
  				category: Category.all.sample,
  				price: "#{Random.rand(500)},#{Random.rand(99)}",
          finish_date: Date.today + Random.rand(90),
          picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(9)}.jpg"),'r')
				)
  	end

    5.times do
      Ad.create!(
          title: Faker::Lorem.sentence([2,3,4,5].sample),
          description: mardown_fake,
          member: Member.first,
          category: Category.all.sample,
          price: "#{Random.rand(500)},#{Random.rand(99)}",
          finish_date: Date.today + Random.rand(90),
          picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(9)}.jpg"),'r')
        )
    end

  	puts "ANÚNCIOS cadastrados com sucesso..."
  end

  def mardown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end
end
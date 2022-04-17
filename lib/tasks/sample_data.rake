namespace :tracker do
  def faker_noun
    [
      Faker::Coin.name,
      Faker::Commerce.product_name,
      Faker::Construction.heavy_equipment,
      Faker::Job.title,
      Faker::House.furniture,
      Faker::Hacker.noun,
      Faker::Food.dish,
      Faker::Food.fruits,
      Faker::Food.ingredient,
      Faker::Food.vegetables,
      Faker::Dessert.variety,
      Faker::Dessert.topping,
      Faker::Vehicle.make_and_model,
      Faker::Team.creature,
      Faker::Movies::HitchhikersGuideToTheGalaxy.specie,
      Faker::TvShows::StarTrek.specie,
      Faker::Creature::Animal.name
    ].sample
  end

  def faker_adjective
    [
      Faker::Coffee.intensifier,
      Faker::Color.color_name,
      Faker::Commerce.material,
      Faker::Construction.material,
      Faker::Hacker.adjective,
      Faker::Creature::Bird.silly_adjective,
      Faker::Creature::Bird.adjective,
      Faker::Creature::Bird.geo
    ].sample
  end

  def faker_verb
    [
      Faker::Verb.base,
      Faker::Verb.base,
      Faker::Hacker.verb
    ].sample
  end

  def faker_description
    [
      Faker::Company.catch_phrase,
      Faker::Food.description,
      Faker::Lorem.sentence,
      Faker::Hipster.sentence,
      Faker::Restaurant.description,
      Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
      Faker::Movies::PrincessBride.quote
    ].sample
  end

  task clear: :environment do
    Card.delete_all
    Person.delete_all
  end

  task create_team_and_project: :environment do
    Person.transaction do
      r = Random.new
      people = (1..r.rand(5..10)).map do
        name = Faker::Name.name
        initials = name.split(" ").map { _1[0, 1] }.join("")
        Person.create!(name:, initials:)
      end
      project = Project.create!(
        name: Faker::Commerce.product_name,
        description: faker_description
      )
      (1..r.rand(30..50)).map do
        card = Card.create!(
          name: "#{faker_verb} the #{faker_adjective} #{faker_noun}".titlecase,
          description: faker_description,
          size: %w[xs sm sm md md md md md md lg lg xl].sample,
          slug: Card.generate_slug,
          project:,
          status: %w[attic unstarted unstarted unstarted unstarted unstarted started done done done].sample,
          person: people.sample
        )
        card.save!
      end
      project.clean_up_positions
    end
  end

  task clear_and_create: [:clear, :create_team_and_project]
end

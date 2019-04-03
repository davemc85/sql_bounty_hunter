require('pry-byebug')
require_relative('models/space_cowboy.rb')


space_cowboy1 = SpaceCowboy.new({
        'name' => 'Boba Bret',
        'bounty_value' => '500000',
        'last_known_location' => 'Hoth',
        'favourite_weapon' => 'Blaster'
  })

space_cowboy1.save()

space_cowboy2 = SpaceCowboy.new({
        'name' => 'Sniper Steve',
        'bounty_value' => '2500',
        'last_known_location' => 'Endor',
        'favourite_weapon' => 'rifle'
    })

space_cowboy2.save()


space_cowboy3 = SpaceCowboy.new({
        'name' => 'Pistol Phil',
        'bounty_value' => '100',
        'last_known_location' => 'Ewok Village',
        'favourite_weapon' => 'catapult'
    })

space_cowboy3.save()

binding.pry
cowboys = SpaceCowboy.all();

# SpaceCowboy.delete_all();
space_cowboy1.delete();

space_cowboy2.last_known_location = "Death Star"
space_cowboy2.update()


# SpaceCowboy.find_by_name("Boba Bret")

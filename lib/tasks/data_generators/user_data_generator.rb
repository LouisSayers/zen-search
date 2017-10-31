require 'securerandom'
require 'namey'
require 'memoist'

class UserDataGenerator
  extend Memoist

  def initialize
    @name_generator = Namey::Generator.new
  end

  def generate(user_id)
    user_name = @name_generator.name
    login_date = generate_last_login_date
    seconds_in_two_days = 172800
    created_at_date = login_date - seconds_in_two_days

    {
      '_id' => user_id,
      'url' => generate_zendesk_url(user_id),
      'external_id' => SecureRandom.uuid,
      'name' => user_name,
      'alias' => @name_generator.name,
      'created_at' => created_at_date,
      'active' => generate_boolean,
      'verified' => generate_boolean,
      'shared' => generate_boolean,
      'locale' => generate_locale,
      'timezone' => generate_timezone,
      'last_login_at' => login_date,
      'email' => generate_email_from(user_name),
      'phone' => generate_phone_number,
      'signature' => generate_signature,
      'organization_id' => generate_organization_id,
      'tags' => generate_tags,
      'suspended' => generate_boolean,
      'role' => generate_role
    }
  end

  private

  def random_from(sample)
    index = rand(sample.length)
    sample[index]
  end

  def generate_boolean
    rand(2) % 2 == 0
  end

  def generate_zendesk_url(user_id)
    "http://initech.zendesk.com/api/v2/users/#{user_id}.json"
  end

  def generate_organization_id
    rand(10000)
  end

  def generate_phone_number
    parts = 3.times.map { 100 + rand(900) }
    parts.join('-')
  end

  def generate_last_login_date
    seconds_ago = rand(10000000)
    login_time = Time.now - seconds_ago
    Time.at(login_time)
  end

  def generate_signature
    signatures = [
      "Seize the day!",
      "Don't worry be happy :)",
      "No animals were harmed in the making of this signature"
    ]

    random_from(signatures)
  end

  def generate_email_from(user_name)
    provider = random_from(email_sample)
    email_name = user_name.downcase.gsub(/[^a-z0-9]/, '.')

    "#{email_name}@#{provider}.com"
  end

  def generate_role
    random_from role_sample
  end

  def generate_locale
    random_from(locale_sample)
  end

  def generate_timezone
    random_from(timezone_sample)
  end

  def generate_tags
    (0..rand(5)).map { random_from(tag_sample) }
  end

  def email_sample
    %w(gmail hotmail outlook)
  end
  memoize :email_sample

  def role_sample
    %w(admin user temp)
  end
  memoize :role_sample

  def timezone_sample
    %w(Asia/Bangkok Asia/Jakarta America/Toronto Australia/Melbourne Pacific/Auckland America/Louisville America/Matamoros)
  end
  memoize :timezone_sample

  def tag_sample
    %w(Springville Sutton Hartsville/Hartley Diaperville Foxworth Woodlands Herlong Henrietta Mulino Kenwood Wescosville Loyalhanna Gallina Glenshaw Rowe Babb Frizzleburg Forestburg Sandston Delco Belfair Chamberino Roberts Cascades Cawood Disautel Boling Southview Greenbush Canby Bedias Boyd Fresno Shawmut Buxton Winchester Moraida Beechmont Jeff Starks Camptown Glenville Harleigh Tedrow Bonanza Balm Fulford Austinburg Bartonsville Frystown Sparkill Dola Springhill Staples Trail Newry Belmont Ferney Whitewater Hollins Wollochet Cuylerville Bellamy Hillsboro Snelling Fontanelle Dowling Conestoga Dotsero Wilmington Farmington Trinway Vicksburg Kilbourne Gorham Gloucester Riegelwood Snyderville Roland National Faxon Bellfountain Gracey Muir Veyo Highland Kiskimere Hoehne Leola Graball Yogaville Tivoli Kieler Swartzville Salvo Guthrie Kennedyville Delwood Bynum Murillo Kidder Castleton Stewartville Bascom Ticonderoga Wanamie Evergreen Loma Vienna Ypsilanti Idledale Allendale Tilden Layhill Franklin Allensworth Chesterfield Brutus Echo Valmy Chalfant Calverton Flintville Yonah Tetherow Hailesboro Barstow Fruitdale Hachita Hasty Campo Sugartown Munjor Kula Osage Shindler Conway Linwood Greenwich Suitland Independence Bainbridge Goodville Gasquet Fairforest Windsor Hayes Brecon Colton Williamson Marshall Charco Tilleda Frank Fairmount Marion Riceville Ribera Caberfae Breinigsville Bend Troy Fedora Celeryville Stagecoach Bethpage Johnsonburg Santel Wyano Soudan Coinjock Mathews Dunlo Greer Crown Strong Hemlock Stewart Barrelville Martinsville Roy Rockhill Kenvil Connerton Linganore Alleghenyville Cataract Woodruff Chicopee Maplewood Oley Whitmer Hanover Woodlake Saticoy Hinsdale Kaka Abrams Genoa Yettem Chumuckla Dixie Yardville Riverton Boykin Dixonville Iola Chestnut Roderfield Lemoyne Grantville Fredericktown Sterling Freeburn Wright Naomi Delshire Ronco Farmers Foscoe Edgéwatér Guilford Ezel Matthews Blodgett Nicut Smock Finzel Westboro Alafaya Tuttle Aberdeen Rockingham Waikele Masthope Oceola Lookingglass Thomasville Inkerman Vernon Jennings Teasdale Watrous Hiwasse Biehle Benson Allentown Cliff Clarksburg Manila Graniteville Caroleen Sultana Choctaw Camino Groton Toftrees Draper Northridge Cucumber Whitehaven Omar Waiohinu Catharine Fairhaven Kraemer Mayfair Saranap Fairlee Grandview Fairview Williston Leyner Wawona Soham Sheatown Barclay Odessa Southmont Lisco Davenport Cherokee Summertown Clinton Orviston Blanford Wattsville Levant Golconda Gambrills Itmann Lund Shrewsbury Ryderwood Edmund Kersey Veguita Navarre Elizaville Beaulieu)
  end
  memoize :tag_sample

  def locale_sample
    %w(de-AT de-CH de-DE de-LI de-LU dsb-DE dv-MV el-GR en-AU en-BZ en-CA en-GB en-IE en-IN en-JM en-MY en-NZ en-PH en-SG en-TT en-US en-ZA en-ZW es-AR es-BO es-CL es-CO es-CR es-DO es-EC)
  end
  memoize :locale_sample

end

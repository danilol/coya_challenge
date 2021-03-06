class CountryInfo < Base
  attr_accessor :city, :response

  base_uri        "https://restcountries.eu/"

  private

  def make_request
    self.class.get("/rest/v2/capital/#{city}")
  end

  def build_success_response(api_response)
    country = api_response.first

    OpenStruct.new(
      code: 200,
      name: country["name"],
      domain: country["topLevelDomain"],
      alpha2Code: country["alpha2Code"],
      alpha3Code: country["alpha3Code"],
      calling_codes: country["callingCodes"],
      capital: country["capital"],
      alt_spellings: country["altSpellings"],
      region: country["region"],
      subregion: country["subregion"],
      population: country["population"],
      latlng: country["latlng"],
      demonym: country["demonym"],
      area: country["area"],
      gini: country["gini"],
      timezones: country["timezones"],
      borders: country["borders"],
      native_name: country["nativeName"],
      numeric_code: country["numericCode"],
      currencies: country["currencies"],
      languages: country["languages"],
      translations: country["translations"],
      flag: country["flag"],
      regional_blocs: country["regionalBlocs"],
      other_acronyms: country["otherAcronyms"],
      success?: true
    )
  end

  def cache_key
    "country_info:city:#{city}" if city.present?
  end

  def cache_expiration
    1.day
  end
end

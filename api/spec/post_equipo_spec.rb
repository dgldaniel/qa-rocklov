describe "POST /equipos" do
  before(:all) do
    payload = { email: "danieldouglas26@gmail.com", password: "pwd123" }
    result = Sessions.new.login payload

    @user_id = result.parsed_response["_id"]
  end

  context "novo equipo" do
    before(:all) do
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "kramer.jpg"), "rb")

      payload = {
        thumbnail: thumbnail,
        name: "Kramer Eddie Van Halen",
        category: "Cordas",
        price: 299,
      }

      MongoDB.new.remove_equipo payload[:name], @user_id

      @result = Equipos.new.create payload, @user_id
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end

  context "não autorizado" do
    before(:all) do
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "baixo.jpg"), "rb")

      payload = {
        thumbnail: thumbnail,
        name: "Contra Baixo",
        category: "Cordas",
        price: 59,
      }

      @result = Equipos.new.create payload, nil
    end

    it "deve retornar 401" do
      expect(@result.code).to eql 401
    end
  end
end

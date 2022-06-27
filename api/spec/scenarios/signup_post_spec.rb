describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@bol.com.br", password: "pwd123" }
      MongoDB.new.remove_user payload[:email]

      @result = Signup.new.create payload
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuário já existe" do
    before(:all) do
      # dado que eu tenho um novo usuário
      payload = { name: "João da Silva", email: "joao@bol.com.br", password: "pwd123" }
      MongoDB.new.remove_user payload[:email]

      # e o email desse usuário já foi cadastrado no sistema
      Signup.new.create payload

      # quando faço uma requisição para a rota /signup
      @result = Signup.new.create payload
    end

    it "deve retornar 409" do
      # então deve retornar 409
      expect(@result.code).to eql 409
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  examples = [
    {
      title: "cadastro sem nome",
      payload: { email: "danieldouglas26@gmail.com", password: "pwd1234" },
      code: 412,
      error: "required name",
    },
    {
      title: "cadastro sem email",
      payload: { name: "Daniel", password: "pwd1234" },
      code: 412,
      error: "required email",
    },
    {
      title: "cadastro sem senha",
      payload: { name: "Daniel", email: "danieldouglas26@gmail.com" },
      code: 412,
      error: "required password",
    },
  ]

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Signup.new.create e[:payload]
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida error na api" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end

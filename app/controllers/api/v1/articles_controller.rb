class Api::V1::ArticlesController < Api::V1::ApiController
  
  #Lista todos os artigos
  def index
    articles = Article.order('created_at DESC')

    response = {
      data: articles
    }

    render json: response, status: :ok
  end

  # Listar artigo passando ID
  def show
    articles = Article.find(params[:id])

    response = {
      article: articles
    }

    render json: response, status: :ok

  rescue => e
    render json: {error: e.message}, status: :unauthorized
  end

  # Criar um novo artigo
  def create
    article = Article.new(article_params)
    if article.save
      render json: { status: 'SUCCESS', message: 'Artigo Criado com sucesso', data:article}, status: :ok
    end

  rescue => e
    render json: {error: e.message}, status: :unauthorized
  end

  # Excluir artigo
  def destroy
    article = Article.find(params[:id])
    article.destroy

    response = {
      message: 'Artigo excluido com sucesso',
      article: article
    }

    render json: response, status: :ok

  rescue => e
    render json: {error: e.message}, status: :unauthorized
  end

  # Atualizar um artigo
  def update
    article = Article.find(params[:id])
    article.update_attributes(article_params)

    response = {
      article: article,
      message: 'Artigo atualizado com sucesso'
    }

    render json: response, status: :ok

  rescue => e
    render json: {error: e.message}, status: :unauthorized
  end

  private

  # Parametros aceitos
  def article_params
    params.permit(:title, :body)
  end
end
class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[ show edit update destroy ]

  # GET /publications or /publications.json
  def index
    @publications = Publication.all
  end

  # GET /publications/1 or /publications/1.json
  def show
    @Users = User.all
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications or /publications.json
  def create
    @publication = Publication.new(publication_params)
    @publication.users << current_user  # Para permitir agregar el usuario actual a la publicación

    respond_to do |format|
      if @publication.save
        format.html { redirect_to publication_url(@publication), notice: "Publication was successfully created." }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1 or /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to publication_url(@publication), notice: "Publication was successfully updated." }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1 or /publications/1.json
  def destroy
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to publications_url, notice: "Publication was successfully destroyed." }
      format.json { head :no_content }
    end
  end

#########################################################################

  def mypostulations
    @users = User.all
    user_id = current_user.id
    user = User.find(user_id)
    @postulations = user.publications # Me resultó, de alguna manera que aún no determino, pero me manejo mejor con controladores :D
  end

  def register_user
    @user = User.new()
    @user = User.find(params[:name, :age, :description, :role, images: []])
  end


# Está copiado desde Crazy4Cats, así que lo tengo que adaptar para este proyecto

# before_action :authenticate_user!, except: [:index, :show]  # Para que los no ingresados puedan sólo ver las reacciones, pero no reaccionar

def new_user_postulation
  @publication = Publication.find(params[:publication_id]) if params[:publication_id]
  current_user.publications << @publication

  redirect_to @publication, notice: "Postulación recibida"
end
#########################################################################


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:name, :description, images: [] )
    end
end

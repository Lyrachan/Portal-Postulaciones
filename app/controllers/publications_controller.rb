class PublicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user!, except: [:index, :show]
  # Dentro  del método authorize_admin, se verifica que el current_user.role sea "admin" o no, y 
  # a partir de ahí permite ejecutar el CRUD de publicaciones y registro de usuarios
  before_action :authorize_admin, only: [:register_user, :create_user, :new, :create, :update, :destroy]  
  before_action :set_publication, only: %i[ show edit update destroy ]


  # La creación de usuarios está en este mismo controlador, en la sección de ##### Controladores Adicionales #####


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

###########################################################################################################################
                  # Controladores adicionales

  def mypostulations
    @users = User.all
    user_id = current_user.id
    user = User.find(user_id)
    @postulations = user.publications # Me resultó, de alguna manera que aún no determino, pero me manejo mejor con controladores :D
  end

  def register_user
    if current_user.admin?
      @user = User.new
    else
      flash[:alert] = "No tienes permiso para realizar esta acción"
      redirect_to root_path
    end
  end

  def create_user
    if current_user.admin?
      @user = User.new(user_params) # @user será el usuario nuevo, por lo que aquí se establecen los parámetros para que los alamacene temporalmente la página
        if @user.save
          UserMailer.with(user: @user).welcome_email.deliver_now  # Con el ActionMailer, puede enviar correos a usuarios nuevos :3
                                                                  # En este caso, se está enviando al usuario nuevo.

          flash[:alert] = "El usuario se ha registrado exitosamente"
          redirect_to register_user_path
        else
          flash[:alert] = "El usuario no ha podido registrarse"
          render :register_user
        end
    else
      flash[:alert] = "No tienes permiso para realizar esta acción"
      redirect_to root_path
    end
  end

  def authorize_admin
    if current_user.role != "admin"
      flash[:alert] = "No tienes permiso para realizar esta acción"
      redirect_to root_path
    end
  end
  

# Está copiado desde Crazy4Cats, así que lo tengo que adaptar para este proyecto

# before_action :authenticate_user!, except: [:index, :show]  # Para que los no ingresados puedan sólo ver las reacciones, pero no reaccionar

def new_user_postulation
  
  @publication = Publication.find(params[:publication_id]) if params[:publication_id]
  current_user.publications << @publication

  # @user = params[:user] # Esta línea estaba generando error, porque en la línea de arriba el usuario está planteado como current_user
  PublicationsMailer.with(user: current_user, publication: @publication).postulate_user.deliver_now

  redirect_to @publication, notice: "Postulación recibida"
end
#########################################################################################################################


  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:name, :description, images: [] )
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :age, :description, :role, images: [])
    end
end

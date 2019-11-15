class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    # In order to access the specific ingredient, since it is stored as an object in a hash, stored
    # itself in a hash (we can see it by RAISING the create method), we first access the first object DOSE in the
    # hash, then the second object INGREDIENT in the hash associated with DOSE
    @ingredient = Ingredient.find(params[:dose][:ingredient])

    @dose = Dose.new(dose_params)

    @dose.ingredient = @ingredient
    @dose.cocktail = @cocktail

    @dose.save

    # We decided to redirect to the page of the specific cocktail we've just added to a new dose
    # We do that by passing the argument @cocktail which has been found via
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy

    redirect_to root_path
  end

  private

  def dose_params
    params.require(:dose).permit(:description)
  end
end

class EmailsController < ApplicationController
  def new
    # Formulario para enviar correos
  end

  def send_email
    recipient_email = params[:email]

    # Usar el mailer para enviar el correo
    if UserMailer.test_email(recipient_email).deliver_now
      flash[:notice] = "Correo enviado correctamente a #{recipient_email}"
    else
      flash[:alert] = "Hubo un error al enviar el correo."
    end
    redirect_to new_email_path
  end
end

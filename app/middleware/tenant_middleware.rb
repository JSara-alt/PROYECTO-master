class TenantMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    subdomain = request.host.split('.').first
    Rails.logger.debug "Subdominio detectado: #{subdomain}"
    
    tenant = Tenant.find_by(subdomain: subdomain)
    if tenant
      Rails.logger.debug "Tenant encontrado: #{tenant.name}"
      Tenant.current = tenant
    else
      Rails.logger.debug "Tenant no encontrado para el subdominio: #{subdomain}"
      return [404, { 'content-type' => 'text/html' }, ['Tenant not found']]
    end

    @app.call(env)
  ensure
    Tenant.current = nil
  end
end

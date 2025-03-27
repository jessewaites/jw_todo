class ConfigurationsController < ApplicationController
  def ios_v1
    render json: {
      settings: {},
      rules: [
        {
          patterns: [
            "/new$",
            "/edit$",
            "/users/sign_in",
            "/users/sign_up"
          ],
          properties: {
            context: "modal"
          }
        }
      ]
    }
  end
end

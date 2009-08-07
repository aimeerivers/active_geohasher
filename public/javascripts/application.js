// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function update_home_location(lat, lng) {
  new Ajax.Request('/update_location/', {
    method: 'put',
    parameters: {
      lat: lat,
      lng: lng,
      authenticity_token: AUTH_TOKEN
    }
  });
}

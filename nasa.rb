require_relative('request')
api = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key='
key = '5PZ5Dpr6M8jM4gz2jG0GYFS95nJUgVfSp1ydqgco'

def head
"<!doctype html>
<html lang='es'>
\t<head>
        <!-- Required meta tags -->
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
        <!-- Bootstrap CSS -->
        <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' integrity='sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z' crossorigin='anonymous'>
        <!-- Favicon -->
        <link rel='shortcut icon' href='assets/img/nasa-navbar.png'>
        <!-- Font Awesome -->
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>
        <!-- Estilos CSS -->
		<link rel='stylesheet' href='assets/css/style.css'>
        <title>Nasa</title>
\t</head>
\t<body>\n"
end

def navbar
    "\t\t<nav class='navbar navbar-expand-lg navbar-dark bg-dark'>
            <div class='container'>
                <a class='navbar-brand' href='#'><img src='assets/img/nasa-navbar.png' style='width:75px; height:75px'></a>
                <button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#navbarNavAltMarkup' aria-controls='navbarNavAltMarkup' aria-expanded='false' aria-label='Toggle navigation'>
                    <span class='navbar-toggler-icon'></span>
                </button>
                <div class='collapse navbar-collapse' id='navbarNavAltMarkup'>
                    <div class='navbar-nav ml-auto'>
                        <a class='nav-link' href='#'>Home</a>
                        <a class='nav-link' href='#'>About</a>
                        <a class='nav-link' href='#'>Contact</a>
                    </div>
                </div>
            </div>
\t\t</nav>\n"
end

def header
"\t\t<header>
            <figure>
                <img src='assets/img/header.jpg' style='width:100%; height:100vh'>
            </figure>
        </header>\n"
end

def build_web_page(api,api_key)
    data = request(api,api_key)
    img_nasa = 
        "\t\t<h1 class='text-center text-light py-3 font-weight-bold'>Mars Rover Photos</h1>
        <div class='container'>
        \t<div class='row'>\n"
    # img_nasa = "\t\t<ul>\n"
    data['photos'].each do |photos_info|
        
    img_nasa += 
    "\t\t\t\t<div class='col-md-4'>    
        \t\t\t<div class='card mb-3 mx-auto'>
            \t\t\t<img src='#{photos_info['img_src']}' class='card-img-top' alt='#{photos_info['id']}' style='height:300px'>
            \t\t\t<div class='card-body'>
                \t\t\t<h5 class='card-title text-center font-weight-bold'>ID: #{photos_info['id']}</h5>
                \t\t\t<p class='card-text text-center'>Foto obtenida de la Cámara #{photos_info['camera']['name']}</p>
            \t\t\t</div>
        \t\t\t</div>
    \t\t\t</div>\n"
    end
    img_nasa += 
    "\t\t\t</div>
    \t</div>\n"
end

def footer
    "\t\t<footer class='bg-dark d-flex justify-content-end align-items-center' style='height: 100px; width: 100%'>
            <div class='my-auto'>
                <a href='https://www.facebook.com/NASA/' class='text-light'><i class='fa fa-facebook-square fa-3x px-3' aria-hidden='true'></i></a>
                <a href='https://www.instagram.com/nasa/?hl=es-la' class='text-light'><i class='fa fa-instagram fa-3x px-3' aria-hidden='true'></i></a>
                <a href='https://twitter.com/nasa' class='text-light'><i class='fa fa-twitter-square fa-3x px-3' aria-hidden='true'></i></a>
            <div>
    \t</footer>\n\n"
end

def foot
        "\t\t<!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src='https://code.jquery.com/jquery-3.5.1.slim.min.js' integrity='sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj' crossorigin='anonymous'></script>
        <script src='https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js' integrity='sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN' crossorigin='anonymous'></script>
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js' integrity='sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV' crossorigin='anonymous'></script>
\t</body>
</html>"
end

def photos_count(api,api_key)
    data = request(api,api_key)
        hash = {}
        data['photos'].each do |ph_info|
            hash[ph_info['camera']['name']] = 0
        end
        data['photos'].each do |ph_info|
            hash[ph_info['camera']['name']] += 1 if ph_info['camera']['name'] == ph_info['camera']['name']
        end
    print hash
end
photos_count(api,key)

nasa = head() + navbar() + header() + build_web_page(api, key) + footer() + foot()
File.write('index.html', nasa)
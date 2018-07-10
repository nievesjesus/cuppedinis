# Cuppedinis

[![N|Cuppedinis](https://cuppedinis.com/assets/images/logo-icon.png)](https://cuppedinis.com/)

Si quieres conocer un poco mas visita el sitio de [cuppedinis.com](https://cuppedinis.com/) o mira el [video introductor](https://www.youtube.com/watch?v=8oBa57XjR_A).

Mercadopago en Swift simple y eficiente.
Clase para consulta de la api de mercadopago, con callbacks y objetos mapeados

# Como nace Cuppedinis

La idea inicial era crear un método sencillo para lograr una comunicación entre la una app de swift y el api de MercadoPago, teniendo en cuenta las siguientes cosas:

  - Modularizar.
  - Callbacks de llamadas.
  - Reutilización de código.
  - Rapido acceso a las llamadas

Para esto se implemento una metodología para la creación de la clase de conexión que funcionara resolviendo todas las necesidades principales y ademas que fuera compatible con diferentes patrones de diseño y desarrollo como ReactiveDevelopment, MVVM, MVCN entre otros.  


Se implemento usando un método de capa de abstracción de red, que es una comunicación entre cualquier código y una API, esta capa se creo y se implemento usando [Moya](https://github.com/Moya/Moya).

### Tecnología

Cuppedinis y este proyecto en general usan diferentes librerías OpenSource para trabajar correctamente:

* [Moya](https://github.com/Moya/Moya) - Es una capa de abstracción de red entre su código y Alamofire para Swift. Tiene muchas funciones como proveedores personalizados, complementos y otros.
* [Kingfisher](https://github.com/onevcat/Kingfisher) - Es una biblioteca liviana y pura de Swift para descargar y almacenar en caché las imágenes de la web.
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) - ObjectMapper es un framework escrito en Swift que hace que sea fácil para usted convertir sus objetos modelo (clases y estructuras) hacia y desde JSON.
* [NumPad](https://github.com/efremidze/NumPad) - Pad numérico inspirado en Square. El módulo está basado en LEAmountInputView.
* [TTGSnackbar](https://github.com/zekunyan/TTGSnackbar) - Una implementación basada en Swift de Android Snackbar para iOS.
* [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView) - NVActivityIndicatorView es una colección de impresionantes animaciones de carga.
* [Cocoapods](https://cocoapods.org/) - Gestor de dependencias para SWiFT y Objective-C.

Otras herramientas y tecnologías usadas para llevar este proyecto a cabo y que no tienen que ver directamente con el código, como recursos, web, video ,etc.


* [Photoshop](https://www.adobe.com/products/photoshop.html) - Se utilizo para editar y ajustar las imágenes y recursos de la aplicación.
* [Visual Studio Code](https://code.visualstudio.com/) - Se utilizo para crear el landing de la web inicial de Cuppedinis
* [QuickTime Player](https://support.apple.com/downloads/quicktime) - Para grabar el funcionamiento de la app.
* [Filmora](https://filmora.wondershare.com/) - Programa de edición utilizado para crear la presentación.
* [Flaticon](https://www.flaticon.com/) - Fuente principal para los iconos dentro de la aplicación.
* [DigitalOcean](https://www.digitalocean.com/) - Servidor en la nube que alojar el sitio de Cuppedinis.
* [Let's Encrypt](https://letsencrypt.org/getting-started/) - Utilizado para manejar los certificados SSL del sitio web.
* [Nginx](https://www.nginx.com/) - Servidor HTTP para la web.


### Instalación

Este proyecto requiere de [Cocoapods](https://cocoapods.org/) para funcionar 

Abre el terminal y dirígete al directorio donde instalaras la app, luego clona el repositorio (debes tener instalado git).

```sh
$ cd tu-directorio-de-trabajo
$ git clone https://github.com/nievesjesus/cuppedinis.git
$ cd cuppedinis
$ pod install
```


### Configuración

Para usar el api de MercadoPago es requerido que utilices una apikey pública para conectarte a la restapi, para que Cuppedinis tome esa llave, debes cambiar la configuración en el archivo Info.plist y reemplazar el valor que ahi aparece por el valor de tu llave.

Localiza el archivo Info.plist del proyecto.

![N|Configuracion-01](https://cuppedinis.com/assets/images/config001.png)

Agrega tu llave donde dice YOURKEY:

![N|Configuracion-02](https://cuppedinis.com/assets/images/config002.png)


### Compila y prueba

Ahora ejecuta la aplicación en el emulador o un dispositivo físico y prueba que sencillo es utilizar Cuppedinis. Esta app esta ajustada para dispositivos chicos y grandes, ha sido ajustadas para iPhone SE y todos los dispositivos consecuentes, aplicando scrollview donde fuera necesario para asegurar el acceso a todos los elementos UI dentro de la misma.

### Curiosidades; tipo de programación.

Debido al poco tiempo para desarrollar la appp de demo en esta primera etapa se implemente un patron de programación híbrido entre MVVM y MVCN, para lograr un flujo de navegación mas persistente, la app consta de dos Storyboards uno para la pantalla principal y otro para el flujo de pago. 

La navegación no es por SEGUES, para mantener un control total en que controlador se presenta, como se presenta y que datos contiene cuando es llamado a ser cargado en el ciclo de vida de la app. Asi que no encontraras referencias de SEGUES en la app, mantiene una clase BaseViewController la cual tiene la referencia a los storyboards del proyecto, esta referencia se usa para referencias vistas de cada uno de estos storyboards.

Al mantener una navegación de este tipo se pueden reutilizar las vistas desde cualquier instancia de la app, se referencia y se presentan, tomando esa idea de los patrones de desarrollo de MVVM. 



### Por hacer (TODO)

 - Crear librería en base a la clase de este demo
 - Agregar todas las funciones de la api de MercadoPago.
 - Integrar con API de MercadoLibre
 - Integrar con API de MercadoShop

Licencia
----

MIT


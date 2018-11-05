

class Persona{
	
	const peso = 0
	var property jarrasCompradas = []
	const leGustaLaMusica = null
	var property marcaFavorita = null
	const aguante = 0
	
	method nacionalidad() ="otros"
	
	method estaEbria() = self.alcoholIngirido() * peso > aguante
	
	method comprarCerveza(carpa,litros) {
		 carpa.dejarEntrarAPersona(self)
	return	if( self.dentroDeUnaCarpa(carpa) and self.leGusta(carpa) )
			 self.tomarCerveza(carpa,litros)
		else 0
		}
	
	method leGusta(carpa) = leGustaLaMusica == carpa.musicaEnLaCarpa() and marcaFavorita == carpa.marcaQueVende()
	
	method dentroDeUnaCarpa(carpa) = carpa.personasDentro().contains(self)
	
	method tomarCerveza(carpa,litrosDeseados) =  jarrasCompradas.add(carpa.darJarraDeCerveza(litrosDeseados))
	
	method alcoholIngirido() = jarrasCompradas.sum{jarra => jarra.contenidoAlcolico()}
	
	method cantidadCompradas() = jarrasCompradas.size()
	
	method esMuytomador() = jarrasCompradas.all{jarra => jarra.litros() >= 1}
	
	method tomadorPatriota() = jarrasCompradas.all{jarra => jarra.marcaDeOrigen() == self.nacionalidad()}
	
}

class Aleman inherits Persona {
	
	override method nacionalidad() ="Alemania"
	
	override method leGusta(carpa) = carpa.genteEnLaCarpa() < carpa.limite() and leGustaLaMusica ==carpa.musicaEnLaCarpa()
	
}

class Belga inherits Persona {
	
	override method nacionalidad() = "Belgica"
	
	override method leGusta(carpa) = carpa.infoDeLupulo() > 4 and leGustaLaMusica ==carpa.musicaEnLaCarpa()
	
}

class Checo inherits Persona {
	
	override method nacionalidad() = "Checo"
	
	override method leGusta(carpa) = carpa.infoGraduacion() > 0.08 and leGustaLaMusica ==carpa.musicaEnLaCarpa()
	
}

class Carpa{
	
	const limiteDePersonas = 0
	const ambientacionConMusicas = null // bool
	var property marcaQueVende = null
	var property personasDentro = []
	
	method genteEnLaCarpa() = personasDentro.size()
	
	method personasDentro() = personasDentro
	
	method marcaQueVende() = marcaQueVende
	
	method musicaEnLaCarpa() = ambientacionConMusicas
	
	method dejarEntrarAPersona(persona) {
		if(not persona.estaEbria() && self.genteEnLaCarpa() < self.limite() ){
			personasDentro.add(persona)
		}else{
			personasDentro.add()
			 }
	}						  
	
	method darJarraDeCerveza(litrosDeseados) = new Jarra(litros=litrosDeseados, marca=marcaQueVende) //_______________!
	
	method limite() = limiteDePersonas
	
	method infoDeLupulo() = marcaQueVende.lupulo()
	
	method infoDeGraduacion() = marcaQueVende.graducion()
	
	method ebrioEnpedernidos() = personasDentro.map{persona => persona.esMuytomador()}.size()
	
}

class Jarra{
	
	var property litros = 0
	const marca = null
	
	method marcaDeOrigen() = marca
	
	method litroEnLaJarra() = litros
	
	method contenidoAlcolico() = litros * marca.graduacion() //_____________!
	 
}

class Marca{
	
	const lupulo = 0
	var property pais = null // "alemania" "belgica" "checo"
	var property graduacion = 0
	
	method lupulo() = lupulo
	
	method pais() = pais
	
}

class Corona inherits Marca{
		
	method graduacion() = (graduacion / 100)
	
}

class Guiness inherits Marca{
	
	method graduacion() = graduacionReglamentaria.graduacionMundial() + lupulo * 2
	
}

class Hofbrau inherits Guiness{
	
	override method graduacion() = super() * 1.25
	
}

object graduacionReglamentaria{
	
	method graduacionMundial() = 0.2
	
}


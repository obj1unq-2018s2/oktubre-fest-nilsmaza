

class Persona{
	
	const peso = 0
	var property jarrasCompradas = []
	const leGustaLaMusica = null
	const marcaFavorita = null // "Corona" "Hofbrau" "Guiness"
	const aguante = 0
	
	method nacionalidad() ="otros"
	
	method estaEbria() = self.alcoholIngirido() * peso > aguante
	
	method comprarCerveza(carpa,litros) {
		 carpa.dejarEntrarAPersona(self)
	return	if( self.dentroDeUnaCarpa(carpa) and self.leGusta(carpa) )
			 self.tomarCerveza(carpa,litros)
		else 0
		}
	
	method leGusta(carpa) = leGustaLaMusica == carpa.musicaEnLaCarpa() and marcaFavorita == carpa.marcaDeLaCerveza()
	
	method dentroDeUnaCarpa(carpa) = carpa.personasDentro().contains(self)
	
	method tomarCerveza(carpa,litrosDeseados) =  jarrasCompradas.add(carpa.darJarraDeCerveza(litrosDeseados))
	
	method alcoholIngirido() = jarrasCompradas.sum{jarra => jarra.contenidoAlcolico()}
	
	method cantidadCompradas() = jarrasCompradas.size()
	
	method esMuytomador() = self.estaEbria() and jarrasCompradas.all{jarra => jarra.litros() >= 1}
	
	method tomadorPatriota() = jarrasCompradas.all{jarra => jarra.marcaDeOrigen() == self.nacionalidad()}
	
}

class Aleman inherits Persona {
	
	override method nacionalidad() ="Alemania"
	
	override method leGusta(carpa) = carpa.genteEnLaCarpa() < 2 and leGustaLaMusica ==carpa.musicaEnLaCarpa()
	
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
	const cervezaQueVende = null // 
	var property personasDentro = []
	
	method genteEnLaCarpa() = personasDentro.size()
	
	method personasDentro() = personasDentro
	
	method musicaEnLaCarpa() = ambientacionConMusicas
	
	method dejarEntrarAPersona(persona) {
		if(not persona.estaEbria() && self.genteEnLaCarpa() < self.limite() ){
			personasDentro.add(persona)
		}else{
			personasDentro.add()
			 }
	}						  
	
	method darJarraDeCerveza(litrosDeseados) = new Jarra(litros=litrosDeseados, cerveza=cervezaQueVende) //_______________!
	
	method limite() = limiteDePersonas
	
	method infoDeLupulo() = cervezaQueVende.lupulo()
	
	method infoDeGraduacion() = cervezaQueVende.graducion()
	
	method marcaDeLaCerveza() = cervezaQueVende.marcaDeOrigen()
	
	method ebrioEnpedernidos() = personasDentro.count{persona => persona.esMuytomador()}
	
}

class Jarra{
	
	var property litros = 0
	const cerveza = null // 
	
	method marcaDeOrigen() = cerveza
	
	method litroEnLaJarra() = litros
	
	method contenidoAlcolico() = litros * cerveza.graduacion() //_____________!
	 
}

class Cerveza{ // Marca
	
	const lupulo = 0
	var property pais = null // "alemania" "belgica" "checo"
	var property graduacion = 0
	const marca = null // "Corona" "Hofbrau" "Guiness"
	
	method marcaDeOrigen() = marca
	
	method lupulo() = lupulo
	
	method pais() = pais
	
}

class Rubia inherits Cerveza{
		
	method graduacion() = (graduacion / 100)
	
}

class Negra inherits Cerveza{
	
	method graduacion() = graduacionReglamentaria.graduacionMundial().min(lupulo * 2)
	
}

class Roja inherits Negra{
	
	override method graduacion() = super() * 1.25
	
}

object graduacionReglamentaria{
	
	method graduacionMundial() = 0.2
	
}


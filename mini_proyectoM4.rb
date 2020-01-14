require 'colorize'

class Inventory

	attr_accessor :nombre
	attr_accessor :precio
	attr_accessor :cant_disp

	def initialize (nombre,precio,cant_disp)
		@nombre = nombre
		@precio = precio
		@cant_disp = cant_disp
	end
end

class Factura
 		attr_accessor :id
 		attr_accessor :nombre
 		attr_accessor :precio
 		attr_accessor :cant_v

 		def initialize(id,nombre,precio,cant_v)
 			@id = id
 			@nombre = nombre
 			@precio = precio
 			@cant_v = cant_v
 		end
end

$inventario = [Inventory.new("Harina de Maiz",1.5,100),
			   Inventory.new("Pasta",1.5,100),
			   Inventory.new("Arroz",1.0,100),
			   Inventory.new("Harina de Trigo",2.0,100),
			   Inventory.new("Azucar",1.0,100),
			   Inventory.new("Aceite Vegetal",2.0,100),
			   Inventory.new("Leche en Polvo",3.0,100),
			   Inventory.new("Carne de Res",2.5,100),
			   Inventory.new("Pollo",3.0,100),
			   Inventory.new("Mortadela",2.0,100),
			   Inventory.new("Salsa de Tomate",2.0,100),
			   Inventory.new("Mayonesa",20.0,100),
			   Inventory.new("Carton de Huevos",3.0,100),
			   Inventory.new("Crema Dental",0.5,100),
			   Inventory.new("Jabon de Baño",0.5,100),
			   Inventory.new("Detergente en Polvo",2.0,100),
			   Inventory.new("Papel Higienico",0.5,100),
			   Inventory.new("Shampoo P&G",3.0,100),
			   Inventory.new("Cloro",1.0,100),
			   Inventory.new("Lavaplatos",0.75,100)
]

# METODOS DE VALIDACION
def validar_opcion_num(x)
	opcion = 0
	until opcion > 0 && opcion <= x
 		opcion = gets.chomp
		opcion = opcion.to_i

		if opcion > 0 && opcion <= x
			break
		end
 		print "\nIngrese una opcion valida: ".red		
 	end

 	return opcion
end

def validar_opcion_let
	opcion = 'z'

	until opcion == 'n' || opcion == 's'
 		opcion = gets.chomp
		opcion.downcase!

		if opcion == 'n' || opcion == 's'
			break
		end
 		print "\nIngrese una opcion valida: ".red		
 	end

 	return opcion
end

def val_nombre
  val_esp = false
  val_long = false
  nombre = ""
  until nombre.length > 0 && nombre.length <= 30 && val_esp != false && val_long != false
    nombre = gets.chomp
    val_long = false

    if nombre.length <= 30
	    chars = nombre.chars
	    let_num = 0
	    chars.each do |let|
	      if let != " "
	        val_esp = true
	        break
	      end
	      let_num += 1
	    end

	    if val_esp != true
			puts "El nombre no puede estar vacio".red
			print "Ingrese nombre del articulo: ".yellow
			let_num = 0
		end
		val_long = true
	else 
		puts "El nombre no puede superar los 30 caracteres".red
		print "Ingrese nombre del articulo: ".yellow
	end
    
    
  end
  
  new_chars = []
  chars.each do |let|
    
    if let_num <= 0
      new_chars << let
    end
    let_num -= 1
  end
  
  nombre = new_chars.join("")
  newNameArt = nombre.downcase
  
  $inventario.each do |articulo|
  	nameArt = articulo.nombre.downcase
  	
  	if nameArt === newNameArt
  		puts "Ya existe un articulo con este nombre".red
		print "Ingrese nombre del articulo: ".yellow
		val_nombre
  	end
  end 
  nombre.capitalize!
  return nombre
end

def val_cifra(word,precio=false)
	cifra = 0
	val_long = false

	until cifra > 0 && val_long != false
		cifra = gets.chomp
		cifra = cifra.to_f

		if cifra <= 0 || cifra > 99999
		 	puts "Debe ingresar un valor valido mayor a cero y menor a 100000".red
		 	print "Ingrese #{word} del articulo: ".yellow
		else 
			if precio != false
				cifra = (cifra*100).round / 100.0
				sem_cifra = cifra.to_s

				if sem_cifra.to_i > 99999
					puts "El precio no puede ser mayor a 99999$".red
		 			print "Ingrese #{word} del articulo: ".yellow
		 		else 
		 			val_long = true
				end
			else 
				cifra = cifra.to_i
				val_long = true
			end			
		end
	end

	return cifra
end

# METODOS DE MENU
def imprimir_esp(long_name,long_campo)
	long_esp = long_campo - long_name

	long_esp.times do print " " end
end

def center_text(text)
  long = text.length
  margin = (80-long)/2

  margin.times do print " " end
  puts "#{text}".yellow
end

def ver(seguir=false) 
	puts "INVENTARIO DISPONIBLE\n".yellow
	print "ID    ".yellow
	print "Nombre".yellow
	26.times do print " " end
	print "Precio Unit.  ".yellow 
	print "Cant. Disp.\n".yellow
	print "====  ".yellow
	30.times do print "=".yellow end
	print "  "
	12.times do print "=".yellow end
	print "  "
	11.times do print "=".yellow end
 	
 	i = 0
 	$inventario.each do |x| 
 		i+=1
 		print "\n"
 		print '%.4i' % i
 		print "  #{x.nombre}"
 		long_name = x.nombre.length
 		imprimir_esp(long_name,32)

 		precio_i = x.precio.to_i.to_s
 		long_precio = precio_i.length
 		imprimir_esp(long_precio,7)
 		print '%.2f' % x.precio
 		print "$   "
 		
 		cant_disp_i = x.cant_disp.to_s
 		long_cant_disp = cant_disp_i.length
 		imprimir_esp(long_cant_disp,10)
 		print"#{x.cant_disp}"

 	end
	
	unless seguir
		print "\n\n1. Volver al menu principal: ".yellow
		opcion = validar_opcion_num(1)
			
	 	menu 	
	end 

	return i 
end

def actualizar
	
	i = ver(seguir=true)

 	print "\n\nElija la opcion a realizar: (1)Agregar (2)Modificar (3)Eliminar (4)Volver al Menu Principal: ".yellow

 	opcion = validar_opcion_num(4)

 	if opcion == 2 || opcion == 3
 		print "\nIngrese el ID del articulo que desea ".yellow
 	end

 	case opcion
 		when 1 then
 			
			print "\nIngrese nombre del articulo: ".yellow
			nombre = val_nombre
      		
      		print "Ingrese el precio del articulo: ".yellow
			precio = val_cifra("el precio",true)
			
		  	print "Ingrese la cantidad disponible del articulo: ".yellow
 			cant_disp = val_cifra("la cantidad disponible")
 			
 			puts "\nHa registrado los siguientes datos:\n".cyan
 			puts "Nombre: #{nombre}\nPrecio: #{'%.2f' % precio}\nCant. Disp: #{cant_disp}".magenta
 			print "\nDesea guardar estos datos. (s/n): ".yellow
 			opcion_let = validar_opcion_let

 			if opcion_let == 's'
 				$inventario << Inventory.new(nombre,precio,cant_disp)
 				puts "\nGuardado Exitosamente!!!".green
 				puts "Presione Enter para continuar".yellow
 				gets()

 				actualizar
 			else
 				puts "\nLos datos no han sido guardados!!".cyan
 				puts "Presione Enter para continuar".yellow
				gets()

				actualizar
 			end

 		when 2 then 
 			print "modificar: ".yellow

 			item_pos = validar_opcion_num(i) - 1
 		
 			print "\nNombre: #{$inventario[item_pos].nombre}. Modificar (s/n): ".yellow
			opcion_let = validar_opcion_let

			if opcion_let == 's'
				print "Ingrese el nuevo nombre: ".cyan
				nombre = val_nombre

			else
				nombre = $inventario[item_pos].nombre
			end 

			print "\nPrecio: #{$inventario[item_pos].precio}. Modificar (s/n): ".yellow
			opcion_let = validar_opcion_let

			if opcion_let == 's'
				print "Ingrese el nuevo precio: ".cyan
				precio = val_cifra("el nuevo precio",true)

			else
				precio = $inventario[item_pos].precio
			end 

			print "\nCant. Disp: #{$inventario[item_pos].cant_disp}. Modificar (s/n): ".yellow
			opcion_let = validar_opcion_let

			if opcion_let == 's'
				print "Ingrese la nueva cantidad disponible del articulo: ".cyan
				cant_disp = val_cifra("la nueva cantidad disponible")
			else
				cant_disp = $inventario[item_pos].cant_disp
			end 

			puts "\nEstos son los datos registrados".magenta
			puts "\nNombre: #{nombre}\nPrecio: ".cyan + '%.2f'.cyan % precio + "\nCant. Disp: #{cant_disp}".cyan
			print "\nDesea Guardar los Cambios (s/n): ".yellow
			opcion_let = validar_opcion_let

			if opcion_let == 's'
				$inventario[item_pos].nombre = nombre
				$inventario[item_pos].precio = precio
				$inventario[item_pos].cant_disp = cant_disp

				puts "\nGuardado Exitosamente!!!".green
				puts "Presione Enter para continuar".yellow
				gets()

				actualizar
			else 
				puts "\nLos datos no han sido guardados!!".cyan
 				puts "Presione Enter para continuar".yellow
				gets()

				actualizar
			end

 		when 3 then
 			print "eliminar: ".yellow

 			item_pos = validar_opcion_num(i) - 1
 		
 			print "\nNombre: #{$inventario[item_pos].nombre}\nPrecio: #{$inventario[item_pos].precio}\nCant. Disp: #{$inventario[item_pos].cant_disp}.\n\n".magenta
 			print "Esta seguro de eliminar estos datos (s/n): ".yellow
			opcion_let = validar_opcion_let

			if opcion_let == 's'
				$inventario.delete_at(item_pos)
				puts "\nLos datos han sido eliminados Exitosamente!!!".green
				puts "Presione Enter para continuar".yellow
				gets()
				actualizar

			else 
				puts "\nEliminacion Cancelada!!!".cyan
				puts "Presione Enter para continuar".yellow
				gets()
				actualizar
			end
 		
 		when 4 then menu
 	end
	
	gets()
end

def vender
	@i = ver(seguir=true)
 	@factura = [Factura.new(0," ",0.0,0)]

 	print "\n"
 	def facturacion

	 	print "\nIngrese el ID del articulo a vender: ".yellow
	 	item_pos = validar_opcion_num(@i) - 1
		
		if $inventario[item_pos].cant_disp == 0
			print "\nYa no existen unidades disponibles de este articulo".red
			facturacion
		end 
		puts "\nUnids Disp: #{$inventario[item_pos].cant_disp}".cyan
	 	print "Ingrese la cantidad a vender: ".yellow

	 	unids = 0

	 	until unids > 0 && unids <= $inventario[item_pos].cant_disp
		 	unids = gets.chomp
		 	unids = unids.to_i

		 	if unids > 0 && unids <= $inventario[item_pos].cant_disp 
		 		$inventario[item_pos].cant_disp -= unids
		 		break
		 	elsif unids == 0
		 		puts "\nLa cantidad ingresada debe ser mayor a cero(0)".red
		 		print "Ingrese la cantidad a vender: ".yellow
		 	else
		 		puts "\nLa cantidad ingresada excede el numero de unidades disponibles".red
		 		print "Ingrese la cantidad a vender: ".yellow
		 	end		 	
	 	end

	 	item_repeat = false
	 	@factura.each do |item|

	 		if item.nombre == $inventario[item_pos].nombre
	 			item.cant_v += unids
	 			item_repeat = true
	 		end
	 	end
	 	if item_repeat != true
	 		@factura << Factura.new(item_pos+1,$inventario[item_pos].nombre,$inventario[item_pos].precio,unids)
	 	end

	 	print "\nVender otro articulo (s/n): ".cyan
	 	opcion_let = validar_opcion_let

	 	if opcion_let == 's'
	 		facturacion	
	 	end

	 	puts "\n"
	 	center_text("Supermercado Mis Caobos C.A")
	 	center_text("RIF: 31701007-8")
	 	center_text("Direccion: Av. Enma Jaramillo, Sector La Verdoza")
	 	center_text("Teléfono: 0414-8170372")
	 	center_text("Pariaguán, Edo Anzoátegui.")

		puts "\n"
	 	5.times do print " " end
	 	print "Unids  ".yellow
		print "Nombre".yellow
		26.times do print " " end
		print "Precio Unit.  ".yellow 
		10.times do print " " end
		print "Total\n".yellow
		5.times do print " " end
		print "=====  ".yellow
		30.times do print "=".yellow end
		print "  "
		12.times do print "=".yellow end
		print "  "
		15.times do print "=".yellow end
	 	
	 	total_p = 0.0
	 	@factura.each do |item| 
	 		
	 		total = item.cant_v * item.precio

	 		if total > 0
		 		print "\n"
		 		5.times do print " " end
		 		print '%.5i' % item.cant_v

		 		print "  #{item.nombre}"
		 		long_name = item.nombre.length
		 		imprimir_esp(long_name,32)

		 		precio_i = item.precio.to_i.to_s
		 		long_precio = precio_i.length
		 		imprimir_esp(long_precio,7)
		 		print '%.2f' % item.precio
		 		print "$   "
		 		
		 		total_i = total.to_i.to_s
		 		long_total = total_i.length
		 		imprimir_esp(long_total,11)
		 		print '%.2f' % total
		 		print "$"

		 		total_p += total
	 		end
	 	end

	 	print "\n\n"
	 	42.times do print " " end
	 	print "Total a pagar   ".yellow

	 	total_p_i = total_p.to_i.to_s
 		long_total_p = total_p_i.length
 		imprimir_esp(long_total_p,11)
 		print '%.2f' % total_p
 		print "$\n\n"

	 	print "La factura esta lista desea proceder con la venta. (s)Continuar (n)Cancelar: ".cyan
	 	opcion_let = validar_opcion_let

	 	if opcion_let == 's'
	 		@factura.each do |item|
	 			pos = item.id - 1
	 	
	 			if pos != -1
		 			if $inventario[pos].cant_disp == 0
		 				$inventario.delete_at(pos)
		 			end
		 		end
	 		end
	 	else 
	 		@factura.each do |item|
	 			pos = item.id - 1
	 			if pos != -1
	 				$inventario[pos].cant_disp += item.cant_v
	 			end	
	 		end
	 	end
	 	
	 	puts "\n1. Hacer una nueva venta".yellow
	 	print "2. Volver al menu principal: ".yellow
	 	opcion = validar_opcion_num(2)

	 	opcion == 1? vender : menu
	 end
	 
	 facturacion	 
end

def salir
	center_text("Gracias por usar este programa...Bye!!!")
	center_text("Presiona enter para cerrar")
	gets()
end

def menu
	puts "\n"
	puts "                            Supermercado Mis Caobos!".green
	puts "                           Bienvenido Sr. Leonardo!!!".green
	print "    Ingrese el valor que corresponda a la opción que desea realizar y Enter.\n\n".yellow

	puts "                        1. Ver el Inventario disponible".yellow
	puts "                            2. Actualizar Inventario".yellow
	puts "                                   3. Vender".yellow 
	puts "                                   4. Salir\n\n".yellow
	print "Opcion: ".blue.on_white
	opcion = validar_opcion_num(4)
	puts "\n"
	
	case opcion
		when 1 then ver 
		when 2 then actualizar
		when 3 then vender
		when 4 then salir 
	end
end

menu
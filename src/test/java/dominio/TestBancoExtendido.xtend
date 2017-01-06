package dominio

import datosExternosBancos.StubBanco
import org.junit.Before
import java.util.List
import java.util.ArrayList
import org.junit.Test
import org.junit.Assert
import datosExternosBancos.BancoAdapter
import org.junit.After


class TestBancoExtendido {

	    StubBanco stubBanco = new StubBanco
	    List<StubBanco> listaATransformar = new ArrayList<StubBanco>
	    String bancosEnJson
	    String texto
	    BancoAdapter bancoAdapter = new BancoAdapter
	    List<POI> pois = new ArrayList<POI>
        Directorio directorio  
        SucursalBanco sucursalBancoNacion

        
	    @Before
	    def void init(){
  
        var StubBanco banco1 = new StubBanco
		banco1.banco = "Banco de la Plaza"
		banco1.x = -35.9338322
		banco1.y = 72.348353
		banco1.sucursal = "Avellaneda"
		banco1.gerente = "Javier Loeschbor"
		banco1.servicios = #["cobro cheques", "depósitos", "extracciones","transferencias", "créditos"]
		
		var StubBanco banco2 = new StubBanco
		banco2.banco = "Banco de la Plaza"
		banco2.x = -35.9338322
		banco2.y = 72.348353
		banco2.sucursal = "Caballito"
		banco2.gerente = "Fabián Fantaguzzi"
		banco2.servicios = #[ "depósitos", "extracciones","transferencias", "seguros", "", "", "", "" ]
		
		listaATransformar.add(banco1)
		listaATransformar.add(banco2)
		
		bancosEnJson = stubBanco.transformarAJson(listaATransformar)
	    pois = bancoAdapter.transformarBusquedaABanco(bancosEnJson)
	    
	    sucursalBancoNacion = new SucursalBanco("Banco Nacion", "Domicilio del Nacion 1235", null, null, "", null)
	    
	    directorio = Directorio.getInstancia 
	    directorio.create(sucursalBancoNacion)
	    pois.forEach[poi | directorio.create(poi)]

		
    }
    
	@Test
	def void testBuscar() {
		texto = "Banco de la Plaza"
		Assert.assertEquals(directorio.buscar(texto).size, 2)
	}	
	
	@Test
	def void testBuscarQueFalle() {
		texto = "Banco oeste"
		Assert.assertEquals(directorio.buscar(texto).size, 0)
	}
	
	@Test
	def void testBuscarDirectorioInterno() {
		texto = "Banco Nacion"
		Assert.assertEquals(directorio.buscar(texto).size, 1)
	}
	
   @After
    def void limpiarRepo() {
       Directorio.getInstancia.limpiar	
    }
}

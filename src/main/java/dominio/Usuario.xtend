package dominio

import java.util.HashSet
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class Usuario {

	@Id
	@GeneratedValue
	private Long id

	@Column(length=150)
	private String cuenta

	@Column(length=150)
	private String password

	@OneToMany(fetch=FetchType.LAZY)
	Set<Favorito> favoritos = new HashSet

	new() {
	}

	new(String _cuenta, String _password) {
		cuenta = _cuenta
		password = _password
	}

	def sos(String user) {
		cuenta == user
	}
}

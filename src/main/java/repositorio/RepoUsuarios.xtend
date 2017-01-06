package repositorio

import dominio.Usuario
import java.util.List
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions
import org.hibernate.Criteria

class RepoUsuarios extends RepoDefault<Usuario> {

	static RepoUsuarios instancia = null

	private new() {
	}
	
	def static getInstancia() {

		if (instancia == null) {
			instancia = new RepoUsuarios
		}
		return instancia
	}

	override getEntityType() {
		typeof(Usuario)
	}
	
	def List<Usuario> getAll() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(Usuario).list()
		} finally {
			session.close
		}
	}

	def List<Usuario> buscar(Usuario usuario) {
		val session = sessionFactory.openSession

		try {
			val criteriaUsuario = session.createCriteria(Usuario)

			if (usuario.cuenta != null) {
				criteriaUsuario.add(Restrictions.eq("cuenta", usuario.cuenta))
			}
			return criteriaUsuario.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void registrar(Usuario usuario) {
		val session = sessionFactory.openSession

		try {
			session => [
				beginTransaction
				save(usuario)
				transaction.commit
			]
		} catch (HibernateException e) {
			session.transaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}

	}

	def void limpiar() {
		// usuarios.clear
		// this.getObjects.clear
	}

	def Boolean validar(Usuario usuario) {
		val session = sessionFactory.openSession

		try {
			val criteriaUsuario = session.createCriteria(Usuario)

			if (usuario.cuenta != null) {
				criteriaUsuario.add(
					Restrictions.and(Restrictions.eq("cuenta", usuario.cuenta),
						Restrictions.eq("password", usuario.password))
					)
			}
			
			return criteriaUsuario.list.size > 0
			
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	override addQueryByExample(Criteria criteria, Integer id) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override addQueryByExample(Criteria criteria, String nombre) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}

package repositorio

import dominio.POI
import dominio.ParadaDeColectivo
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions

class RepoPois extends RepoDefault<POI> {

	override getEntityType() {
		typeof(POI)
	}

	def POI searchById(Long id) {
		val session = sessionFactory.openSession
		try {
			val criteriaPoi = session.createCriteria(POI)

			if (id != null) {
				criteriaPoi.add(Restrictions.eq("id", id))
			}
			
			return criteriaPoi.list.head
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	override addQueryByExample(Criteria criteria, Integer id) {
		if (id != null && id != 0)
			criteria.add(Restrictions.eq("id", id))
	}

	override addQueryByExample(Criteria criteria, String nombre) {
		if (nombre != null)
			criteria.add(Restrictions.eq("nombre", nombre))
	}	

}

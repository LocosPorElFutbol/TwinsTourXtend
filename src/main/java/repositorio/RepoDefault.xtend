package repositorio

import dominio.Cgp
import dominio.Comercio
import dominio.Favorito
import dominio.POI
import dominio.ParadaDeColectivo
import dominio.SucursalBanco
import dominio.Terminal
import dominio.Usuario
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration
import dominio.Review

abstract class RepoDefault<T> {
	
	protected static final SessionFactory sessionFactory = new Configuration()
		.configure()
		.addAnnotatedClass(Usuario)
		.addAnnotatedClass(Favorito)
		.addAnnotatedClass(POI)
		.addAnnotatedClass(Cgp)
		.addAnnotatedClass(Comercio)
		.addAnnotatedClass(ParadaDeColectivo)
		.addAnnotatedClass(SucursalBanco)
		.addAnnotatedClass(Terminal)
		.addAnnotatedClass(Review)
		.buildSessionFactory()
		

	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}
	
	def List<T> searchByExample(Integer id) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, id)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def List<T> searchByExample(String nombre) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, nombre)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void create(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, Integer id)
	
	def abstract void addQueryByExample(Criteria criteria, String nombre)
	
}
from typing import Type, TypeVar, Generic, List, Optional, Dict, Any
from sqlalchemy.orm import Session
from .db import Base, Player, PlayerStatistic, Team, TeamPlayer, Match, League, Country, Season, SeasonTeam


T = TypeVar('T', bound=Base)

class CRUDBase(Generic[T]):
    def __init__(self, model: Type[T]):
        self.model = model
    
    def get(self, db: Session, id: int) -> Optional[T]:
        """Retorna um registro pelo ID"""
        return db.query(self.model).filter(self.model.id == id).first()
    
    def get_multi(
        self, db: Session, *, skip: int = 0, limit: int = 100
    ) -> List[T]:
        """Retorna múltiplos registros com paginação"""
        return db.query(self.model).offset(skip).limit(limit).all()
    
    def create(self, db: Session, *, obj_in: Dict[str, Any]) -> T:
        """Cria um novo registro"""
        db_obj = self.model(**obj_in)  # type: ignore
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj
    
    def update(
        self, db: Session, *, db_obj: T, obj_in: Dict[str, Any]
    ) -> T:
        """Atualiza um registro existente"""
        for field in obj_in:
            if hasattr(db_obj, field):
                setattr(db_obj, field, obj_in[field])
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj
    
    def remove(self, db: Session, *, id: int) -> T:
        """Remove um registro pelo ID"""
        obj = db.query(self.model).get(id)
        db.delete(obj)
        db.commit()
        return obj
    
    def get_by_field(
        self, db: Session, *, field: str, value: Any
    ) -> Optional[T]:
        """Retorna um registro pelo valor de um campo específico"""
        return db.query(self.model).filter(getattr(self.model, field) == value).first()
    
    def get_multi_by_field(
        self, db: Session, *, field: str, value: Any, skip: int = 0, limit: int = 100
    ) -> List[T]:
        """Retorna múltiplos registros que correspondem a um valor de campo"""
        return (
            db.query(self.model)
            .filter(getattr(self.model, field) == value)
            .offset(skip)
            .limit(limit)
            .all()
        )

# Implementações específicas para cada modelo
class CRUDPlayer(CRUDBase[Player]):
    pass

class CRUDPlayerStatistic(CRUDBase[PlayerStatistic]):
    pass

class CRUDTeam(CRUDBase[Team]):
    pass

class CRUDTeamPlayer(CRUDBase[TeamPlayer]):
    def get_by_team_and_player(self, db: Session, team_id: int, player_id: int) -> Optional[TeamPlayer]:
        return (
            db.query(self.model)
            .filter(self.model.team_id == team_id, self.model.player_id == player_id)
            .first()
        )

class CRUDMatch(CRUDBase[Match]):
    def get_matches_by_team(self, db: Session, team_id: int, skip: int = 0, limit: int = 100) -> List[Match]:
        return (
            db.query(self.model)
            .filter((self.model.home_team_id == team_id) | (self.model.away_team_id == team_id))
            .offset(skip)
            .limit(limit)
            .all()
        )
    
    def get_matches_by_league(self, db: Session, league_id: int, skip: int = 0, limit: int = 100) -> List[Match]:
        return (
            db.query(self.model)
            .filter(self.model.league_id == league_id)
            .offset(skip)
            .limit(limit)
            .all()
        )

class CRUDLeague(CRUDBase[League]):
    pass

class CRUDCountry(CRUDBase[Country]):
    pass

class CRUDSeason(CRUDBase[Season]):
    def get_current_season(self, db: Session, league_id: int) -> Optional[Season]:
        return (
            db.query(self.model)
            .filter(self.model.league_id == league_id, self.model.current == True)
            .first()
        )

class CRUDSeasonTeam(CRUDBase[SeasonTeam]):
    def get_teams_by_season(self, db: Session, season_id: int, skip: int = 0, limit: int = 100) -> List[Team]:
        return (
            db.query(Team)
            .join(self.model)
            .filter(self.model.season_id == season_id)
            .offset(skip)
            .limit(limit)
            .all()
        )
    
    def get_seasons_by_team(self, db: Session, team_id: int, skip: int = 0, limit: int = 100) -> List[Season]:
        return (
            db.query(Season)
            .join(self.model)
            .filter(self.model.team_id == team_id)
            .offset(skip)
            .limit(limit)
            .all()
        )

# Instâncias das classes CRUD para uso na aplicação
#player = CRUDPlayer(Player)
#player_statistic = CRUDPlayerStatistic(PlayerStatistic)
#team = CRUDTeam(Team)
#team_player = CRUDTeamPlayer(TeamPlayer)
#match = CRUDMatch(Match)
#league = CRUDLeague(League)
#country = CRUDCountry(Country)
#season = CRUDSeason(Season)
#season_team = CRUDSeasonTeam(SeasonTeam)